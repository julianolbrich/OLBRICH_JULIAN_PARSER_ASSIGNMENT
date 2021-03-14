// // Importing styling from Mapbox
// import 'mapbox-gl/dist/mapbox-gl.css';
// // Import the JS Object from the package
// import mapboxgl from 'mapbox-gl/dist/mapbox-gl.js';

// const initMapbox = () => {
//   const mapElement = document.getElementById('map');

//   if (mapElement) {
//     // mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
//     mapboxgl.accessToken = 'pk.eyJ1IjoianVsaWFub2xicmljaCIsImEiOiJja205NXQxd3kxMm9tMm9tejlkaHU2YWVjIn0.7R22-aaSaoLIpSoGe3KMFQ'

//     const map = new mapboxgl.Map({
//       container: 'map',
//       style: 'mapbox://styles/mapbox/streets-v10'
//     });

//     const markers = JSON.parse(mapElement.dataset.markers);

//     markers.forEach((marker) => {
//       new mapboxgl.Marker()
//         .setLngLat([marker.lng, marker.lat])
//         .addTo(map);
//     })
//   }

//   // continue here
// };

// export { initMapbox };
