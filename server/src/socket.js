import { io } from "../app.js";

io.on('connection', (socket) => {
    console.log('A user connected:', socket.id);

    socket.emit('PING', 'Hii there buddy!');

    // socket.on('JOIN_ROOM', (chatId) => {
    //     socket.join(chatId);
    //     console.log(`User joined room: ${chatId}`);
    // });

    // socket.on('SEND_MESSAGE', async (message) => {
    //     const chatId = message.chatId;
    //     console.log(`User: ${message.senderId} sent message: ${trimMessageModel(message)}`);

    //     socket.to([chatId, receiverId]).emit('RECEIVE_MESSAGE', trimMessageModel(newMessage));

    // });


    socket.on('disconnect', () => {
        console.log('User disconnected:', socket.id);
    });
});
