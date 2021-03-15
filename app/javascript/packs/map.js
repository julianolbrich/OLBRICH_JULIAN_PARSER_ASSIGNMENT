const initMapbox = () => {

  const mapElement = document.getElementById('map');

    if (mapElement) {
      // mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
      mapboxgl.accessToken = 'pk.eyJ1IjoianVsaWFub2xicmljaCIsImEiOiJja205NXQxd3kxMm9tMm9tejlkaHU2YWVjIn0.7R22-aaSaoLIpSoGe3KMFQ'

      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v10'
      });

      const markers = JSON.parse(mapElement.dataset.markers);

      markers.forEach((marker) => {
        new mapboxgl.Marker()
          .setLngLat([marker.lng, marker.lat])
          .setPopup(new mapboxgl.Popup({ offset: 25 })
          .setHTML(marker.infoWindow.content))
          .addTo(map);
      })

      if (markers.length === 0) {
        map.setZoom(1);
      } else if (markers.length === 1) {
        map.setZoom(14);
        map.setCenter([markers[0].lng, markers[0].lat]);
      } else {
        const bounds = new mapboxgl.LngLatBounds();
        markers.forEach((markers) => {
          bounds.extend([markers.lng, markers.lat]);
        });
        map.fitBounds(bounds, {duration: 1000, padding: 75})
      }

      map.addControl(new MapboxGeocoder({
        accessToken: mapboxgl.accessToken
        // , mapboxgl: mapboxgl
      }));
    }


    // For Algolia / Flat creation / Autocomplete in field 'address'
    const addressInput = document.getElementById('flat_address');

    if (addressInput) {
      const placesAutocomplete = places({
        container: addressInput
      });
  }
};

export { initMapbox };

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
