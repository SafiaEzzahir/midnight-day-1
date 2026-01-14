import asyncio
import websockets

clients = {}
async def broadcast(websocket):
    clients[websocket] = True
    async for message in websocket:
        for client in clients:
            try:
                await client.send(message)
            except:
                clients[client] = None
    clients[websocket] = None

async def broadcast_messages():
    while True:
        await asyncio.sleep(1)

async def main():
    async with websockets.serve(broadcast, "localhost", 9001):
        await broadcast_messages() # forvever

if __name__ == "__main__":
    asyncio.run(main())
