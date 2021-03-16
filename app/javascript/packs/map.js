const initMapbox = () => {

  const mapElement = document.getElementById('map');

    if (mapElement) {
      // mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
      mapboxgl.accessToken = 'pk.eyJ1IjoianVsaWFub2xicmljaCIsImEiOiJja205NXQxd3kxMm9tMm9tejlkaHU2YWVjIn0.7R22-aaSaoLIpSoGe3KMFQ'

      // Initializing Mapbox:
      const map = new mapboxgl.Map({
        container: 'map',
        style: 'mapbox://styles/mapbox/streets-v10'
      });

      // Initializing Markers
      const markers = JSON.parse(mapElement.dataset.markers);
      markers.forEach((marker) => {
        new mapboxgl.Marker()
          .setLngLat([marker.lng, marker.lat])
          .setPopup(new mapboxgl.Popup({ offset: 25 })
          .setHTML(marker.infoWindow.content))
          .addTo(map);
      })

      // Settings for Markers
      if (markers.length === 0) {
        map.setZoom(6);
        map.setCenter([10.4234469, 51.0834196,]);
      } else if (markers.length === 1) {
        map.setZoom(14);
        map.setCenter([markers[0].lng, markers[0].lat]);
      } else {
        const bounds = new mapboxgl.LngLatBounds();
        markers.forEach((markers) => {
          bounds.extend([markers.lng, markers.lat]);
        });
        map.fitBounds(bounds, {duration: 800, padding: 75})
      }

      // Searchfield within map
      // map.addControl(new MapboxGeocoder({
      //   accessToken: mapboxgl.accessToken
      // }));
    }

    // Algolia Autocomnplete / for Address creation
    const addressInput = document.getElementById('flat_address');
    if (addressInput) {
      const placesAutocomplete = places({
        container: addressInput
      });
  };
};

export { initMapbox };
