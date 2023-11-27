const apiKey = "lgLAv0gnfe5veaARpa9wubWE14jm3IoYgmQtCC78";
const url = "https://api.nasa.gov/planetary/apod?";
const numberOfImages = 8;

// random data function
function getRandomDate() {
    const today = new Date();
    const randomDay = Math.floor(Math.random() * 365);
    const randomDate = new Date(today);
    randomDate.setDate(today.getDate() - randomDay);
    return randomDate.toISOString().split('T')[0];
  }
  
  function getMultipleImages() {
    const uniqueDates = new Set();
    while (uniqueDates.size < numberOfImages) {
      const randomDate = getRandomDate();
      const imageData = fetch(`${url}date=${randomDate}&api_key=${apiKey}`)
        .then((response) => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .catch((error) => {
          console.error('There was a problem with the fetch operation:', error);
        });
      imageData.then((data) => {
        if (data.media_type === 'image') {
          uniqueDates.add(randomDate);
        }
      });
    }
    uniqueDates.forEach((date) => {
      fetchImage(date);
    });
  }

function fetchImage(date) {
  fetch(`${url}date=${date}&api_key=${apiKey}`)
    .then((response) => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then((data) => {
      displayImage(data);
    })
    .catch((error) => {
      console.error('There was a problem with the fetch operation:', error);
    });
}

function displayImage(data) {
  const imageContainer = document.querySelector(".container");

  if (data.media_type === 'image') {
    const imageDiv = document.createElement("div");
    imageDiv.classList.add("image-details");

    const imageTitle = document.createElement("h2");
    imageTitle.textContent = data.title;

    const imageDate = document.createElement("p");
    imageDate.textContent = data.date;

    const image = document.createElement("img");
    image.src = data.url;
    image.alt = data.title;

    imageDiv.appendChild(imageTitle);
    imageDiv.appendChild(imageDate);
    imageDiv.appendChild(image);

    imageContainer.appendChild(imageDiv);
  } else {
    console.log('Conteúdo não é uma imagem. Tipo de mídia: ' + data.media_type);
  }
}

// BOTÃO
const updateButton = document.createElement("button");
updateButton.textContent = "Próxima Imagem";
updateButton.addEventListener("click", () => {
  const imageContainer = document.querySelector(".container");
  imageContainer.innerHTML = "";
  getMultipleImages();
});

document.body.insertBefore(updateButton, document.querySelector("script"));
getMultipleImages();
