const events = [
    {
        name: "music festival",
        category: "music",
        seats: 5
    },
    {
        name: "rock concert",
        category: "music",
        seats: 3
    },
    {
        name: "book fair",
        category: "education",
        seats: 4
    }
];

const eventContainer = document.querySelector("#eventContainer");
const categoryFilter = document.querySelector("#categoryFilter");
const searchBox = document.querySelector("#searchBox");

function displayEvents(eventList) {

    eventContainer.innerHTML = "";

    eventList.forEach(event => {

        const card = document.createElement("div");

        const title = document.createElement("h3");
        title.textContent = event.name;

        const registerButton = document.createElement("button");
        registerButton.textContent = "register";

        registerButton.onclick = function () {
            alert(`registered for ${event.name}`);
        };

        card.appendChild(title);
        card.appendChild(registerButton);

        eventContainer.appendChild(card);
    });
}

categoryFilter.onchange = function () {

    const selectedCategory = categoryFilter.value;

    if (selectedCategory === "all") {
        displayEvents(events);
    } else {
        const filteredEvents = events.filter(
            event => event.category === selectedCategory
        );

        displayEvents(filteredEvents);
    }
};

searchBox.addEventListener("keydown", function () {

    const searchText = searchBox.value.toLowerCase();

    const filteredEvents = events.filter(
        event => event.name.toLowerCase().includes(searchText)
    );

    displayEvents(filteredEvents);
});

displayEvents(events);