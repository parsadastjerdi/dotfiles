import type { Plugin } from "@opencode-ai/plugin"
import { createConnection } from "node:net"

const AGENT = "opencode"

type SupacodeEnv = {
  socketPath: string
  worktreeId: string
  tabId: string
  surfaceId: string
}

type HookPayload = {
  hook_event_name: string
  title?: string
  message?: string
  last_assistant_message?: string
}

type SessionMessagesResponse = {
  data?: {
    items?: SessionMessage[]
  }
}

type SessionMessage = {
  info: {
    role: "user" | "assistant"
  }
  parts: MessagePart[]
}

type MessagePart = {
  type: string
  text?: string
}

type SessionStatus =
  | { type: "idle" }
  | { type: "busy" }
  | { type: "retry"; attempt: number; message: string; next: number }

type Event = {
  type: string
  properties?: Record<string, unknown>
}

type SessionStatusEvent = {
  sessionID: string
  status: SessionStatus
}

type SessionIdleEvent = {
  sessionID: string
}

type MessagePartUpdatedEvent = {
  part?: {
    type?: string
    text?: string
  }
}

function readSupacodeEnv(): SupacodeEnv | null {
  const socketPath = process.env["SUPACODE_SOCKET_PATH"]
  const worktreeId = process.env["SUPACODE_WORKTREE_ID"]
  const tabId = process.env["SUPACODE_TAB_ID"]
  const surfaceId = process.env["SUPACODE_SURFACE_ID"]

  if (!socketPath || !worktreeId || !tabId || !surfaceId) return null
  return { socketPath, worktreeId, tabId, surfaceId }
}

function sendToSocket(socketPath: string, data: string): Promise<void> {
  return new Promise((resolve) => {
    let settled = false

    const done = () => {
      if (settled) return
      settled = true
      resolve()
    }

    const client = createConnection({ path: socketPath })

    const timer = setTimeout(() => {
      client.destroy()
      done()
    }, 1000)

    client.on("connect", () => {
      client.write(data, "utf8", () => {
        clearTimeout(timer)
        client.end()
        done()
      })
    })

    client.on("error", () => {
      clearTimeout(timer)
      done()
    })

    client.on("close", () => {
      clearTimeout(timer)
      done()
    })
  })
}

function sendBusy(env: SupacodeEnv, active: boolean) {
  const flag = active ? "1" : "0"
  return sendToSocket(env.socketPath, `${env.worktreeId} ${env.tabId} ${env.surfaceId} ${flag}\n`)
}

function sendNotification(env: SupacodeEnv, payload: HookPayload) {
  return sendToSocket(
    env.socketPath,
    `${env.worktreeId} ${env.tabId} ${env.surfaceId} ${AGENT}\n${JSON.stringify(payload)}\n`,
  )
}

function clip(text: string, max = 4000) {
  if (text.length <= max) return text
  return `${text.slice(0, max - 1)}…`
}

function sleep(ms: number) {
  return new Promise<void>((resolve) => {
    setTimeout(resolve, ms)
  })
}

export const SupacodePlugin: Plugin = async ({ client }) => {
  const env = readSupacodeEnv()

  if (!env) return {}

  const supacodeEnv = env

  let lastAssistantText = ""
  let lastBusyState = false
  let lastNotifiedSessionID = ""
  let lastNotifiedText = ""

  async function publishBusy(active: boolean) {
    if (lastBusyState === active) return
    lastBusyState = active
    await sendBusy(supacodeEnv, active)
  }

  async function fetchLastAssistantText(sessionID: string) {
    for (const delay of [0, 100, 300]) {
      if (delay > 0) {
        await sleep(delay)
      }

      try {
        const response = (await client.session.messages({
          path: {
            id: sessionID,
          },
          query: {
            limit: 20,
          },
        })) as SessionMessagesResponse

        const items = response.data?.items ?? []

        for (let index = items.length - 1; index >= 0; index -= 1) {
          const message = items[index]
          if (message.info.role !== "assistant") continue

          const text = message.parts
            .filter((part) => part.type === "text" && typeof part.text === "string")
            .map((part) => part.text ?? "")
            .join("")
            .trim()

          if (text) return clip(text)
        }
      } catch {}
    }

    return clip(lastAssistantText.trim())
  }

  async function publishStopNotification(sessionID: string) {
    const body = await fetchLastAssistantText(sessionID)
    if (!body) return
    if (lastNotifiedSessionID === sessionID && lastNotifiedText === body) return

    lastNotifiedSessionID = sessionID
    lastNotifiedText = body

    await sendNotification(supacodeEnv, {
      hook_event_name: "Stop",
      last_assistant_message: body,
    })
  }

  return {
    event: async ({ event }) => {
      const typedEvent = event as Event

      if (typedEvent.type === "message.part.updated") {
        const properties = typedEvent.properties as MessagePartUpdatedEvent | undefined
        const part = properties?.part

        if (part?.type === "text" && typeof part.text === "string") {
          lastAssistantText = clip(part.text)
        }

        return
      }

      if (typedEvent.type === "session.status") {
        const properties = typedEvent.properties as SessionStatusEvent | undefined
        const sessionID = properties?.sessionID
        const status = properties?.status

        if (!sessionID || !status) return

        if (status.type === "busy") {
          await publishBusy(true)
          return
        }

        if (status.type === "idle") {
          await publishBusy(false)
          await publishStopNotification(sessionID)
          return
        }

        return
      }

      if (typedEvent.type === "session.idle") {
        const properties = typedEvent.properties as SessionIdleEvent | undefined
        const sessionID = properties?.sessionID
        if (!sessionID) return

        await publishBusy(false)
        await publishStopNotification(sessionID)
      }
    },
  }
}

export default SupacodePlugin
