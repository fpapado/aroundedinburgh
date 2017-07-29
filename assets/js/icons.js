let chillIcon = L.icon({
  iconUrl: '/images/maki/svgs/cafe-11.svg',
  iconSize: [32, 32],
  iconAnchor: [16, 16],
  popupAnchor: [0, -10]
});
let drinkIcon = L.icon({
  iconUrl: '/images/maki/svgs/beer-11.svg',
  iconSize: [32, 32],
  iconAnchor: [16, 16],
  popupAnchor: [0, -10]
});
let eatIcon = L.icon({
  iconUrl: '/images/maki/svgs/restaurant-11.svg',
  iconSize: [32, 32],
  iconAnchor: [16, 16],
  popupAnchor: [0, -10]
});
let studyIcon = L.icon({
  iconUrl: '/images/maki/svgs/library-15.svg',
  iconSize: [32, 32],
  iconAnchor: [16, 16],
  popupAnchor: [0, -10]
});
let visitIcon = L.icon({
  iconUrl: '/images/maki/svgs/town-11.svg',
  iconSize: [32, 32],
  iconAnchor: [16, 16],
  popupAnchor: [0, -10]
});

export default {
  "Chill": chillIcon,
  "Drink": drinkIcon,
  "Eat": eatIcon,
  "Study": studyIcon,
  "Visit": visitIcon
};
