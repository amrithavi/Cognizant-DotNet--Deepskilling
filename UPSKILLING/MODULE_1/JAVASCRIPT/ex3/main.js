const events = [
    {
        name: "music festival",
        date: "2026-06-20",
        seats: 50
    },
    {
        name: "book fair",
        date: "2025-05-10",
        seats: 30
    },
    {
        name: "sports meet",
        date: "2026-07-15",
        seats: 0
    }
];

events.forEach(event => {
    if (new Date(event.date) > new Date() && event.seats > 0) {
        console.log(`${event.name} - available`);
    } else {
        console.log(`${event.name} - hidden`);
    }
});

function registerUser(event) {
    try {
        if (event.seats <= 0) {
            throw new Error("no seats available");
        }

        event.seats--;
        console.log(`registered for ${event.name}`);
    } catch (error) {
        console.log(error.message);
    }
}

registerUser(events[0]);
registerUser(events[2]);