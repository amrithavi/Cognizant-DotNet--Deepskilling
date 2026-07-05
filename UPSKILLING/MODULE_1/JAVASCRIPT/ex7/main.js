const events = [
    {
        name:"music festival",
        seats:5
    },
    {
        name:"book fair",
        seats:3
    }
];
const eventContainer = document.querySelector("#eventContainer");
events.forEach(event=>{
    const card =document.createElement("div");
    const title =document.createElement("h3");
    title.textContent = event.name;
    const seats =document.createElement("p");
    seats.textContent = `available seats: ${event.seats}`;
    const registerButton =document.createElement("button");
    registerButton.textContent = "register";
    const cancelButton =document.createElement("button");
    cancelButton.textContent = "cancel";
    registerButton.onclick =function () {
        if (event.seats>0) {
            event.seats--;
            seats.textContent =`available seats: ${event.seats}`;
        }
    };
    cancelButton.onclick = function () {
        event.seats++;
        seats.textContent = `available seats: ${event.seats}`;
    };
    card.appendChild(title);
    card.appendChild(seats);
    card.appendChild(registerButton);
    card.appendChild(cancelButton);
    eventContainer.appendChild(card);
});