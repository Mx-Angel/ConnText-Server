class TextRoom {
    creator: string;
    roomName: string;
    roomId: number;
    participants: string[] = [];

    constructor(creator: string, roomName: string, roomId: number) {
        this.creator = creator;
        this.roomName = roomName;
        this.roomId = roomId;
    }

    getRoomName(): string {
        return this.roomName;
    }

    getRoomId(): number {
        return this.roomId;
    }

    getCreator(): string {
        return this.creator;
    }
}