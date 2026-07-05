const events = [];

events.push({
    name: "music festival",
    category: "music"
});

events.push({
    name: "book fair",
    category: "education"
});

events.push({
    name: "rock concert",
    category: "music"
});

const musicEvents = events.filter(
    event => event.category === "music"
);

console.log("music events:");
console.log(musicEvents);

const eventCards = events.map(
    event => `event: ${event.name}`
);

console.log("formatted event cards:");
eventCards.forEach(card => {
    console.log(card);
});