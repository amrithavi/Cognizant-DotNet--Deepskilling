class Event {
    constructor(name, category, seats) {
        this.name = name;
        this.category = category;
        this.seats = seats;
    }
}

Event.prototype.checkAvailability = function () {
    if (this.seats > 0) {
        return "seats available";
    } else {
        return "event full";
    }
};

const event1 = new Event(
    "music festival",
    "music",
    50
);

console.log(event1.checkAvailability());

Object.entries(event1).forEach(([key, value]) => {
    console.log(`${key}: ${value}`);
});