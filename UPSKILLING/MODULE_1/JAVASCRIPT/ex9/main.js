const spinner = document.querySelector("#spinner");
const eventList = document.querySelector("#eventList");

fetch("events.json")
    .then(response => response.json())
    .then(events => {

        spinner.style.display = "none";

        events.forEach(event => {
            const li = document.createElement("li");
            li.textContent = event.name;
            eventList.appendChild(li);
        });
    })
    .catch(error => {
        console.log(error);
    });

async function loadEvents() {

    try {

        spinner.style.display = "block";

        const response = await fetch("events.json");
        const events = await response.json();

        spinner.style.display = "none";

        console.log("events loaded using async/await");

    } catch (error) {

        console.log(error);

    }
}

loadEvents();