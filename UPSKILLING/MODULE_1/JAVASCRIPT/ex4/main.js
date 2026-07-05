const events = [];

function addEvent(name, category, seats) {
    events.push({
        name,
        category,
        seats
    });
}

function registerUser(eventName) {
    const event = events.find(e => e.name === eventName);

    if (event && event.seats > 0) {
        event.seats--;
        console.log(`registered for ${event.name}`);
    } else {
        console.log("registration failed");
    }
}

function filterEventsByCategory(category, callback) {
    const filteredEvents = events.filter(
        event => event.category === category
    );

    callback(filteredEvents);
}

function createRegistrationTracker() {
    let totalRegistrations = 0;

    return function () {
        totalRegistrations++;
        return totalRegistrations;
    };
}

const musicTracker = createRegistrationTracker();

addEvent("music festival", "music", 50);
addEvent("book fair", "education", 30);
addEvent("rock concert", "music", 20);

registerUser("music festival");

console.log(`music registrations: ${musicTracker()}`);
console.log(`music registrations: ${musicTracker()}`);

filterEventsByCategory("music", function (events) {
    events.forEach(event => {
        console.log(event.name);
    });
});