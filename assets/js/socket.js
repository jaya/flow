import { Socket } from 'phoenix';
window.socket = new Socket('/socket', { params: { token: window.userToken } });
window.socket.connect();
