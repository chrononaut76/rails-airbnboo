import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { apiKey: String,
  markers: Array }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue;
     this.map = new mapboxgl.Map({
      container: this.element,
      style: 'mapbox://styles/mapbox/streets-v11',
    });
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach((marker) => {
      bounds.extend([marker.lng, marker.lat])
      this.map.fitBounds(bounds, {
      padding: 40,
      });
    });
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
    new mapboxgl.Marker()
    .setLngLat([marker.lng, marker.lat])
    .setPopup(popup)
    .addTo(this.map);
  });
  }
}
