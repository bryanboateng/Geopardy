/*:
 # Geopardy!
 Geopardy is a quiz that challenges your topographic knowledge of the world.\
 Guess the correct country based on its shape.
 
 **Run the lines below to get started**
*/
import PlaygroundSupport
PlaygroundPage.current.liveView = ViewController()
/*:
 - important: Because of a bug related to Swift Playgrounds, sometimes when running Geopardy for the first time, the answer buttons are not clickable. If that occurs, re-run the playground make them work again.
 ---
 Country coordinates provided by: [geojson-maps](https://geojson-maps.ash.ms)
 
 - note:Due to the resolution of the data (50 m accuracy) some small countries may not be shown accurate.\
 The data does not include the stretch that occurs to countries near the poles in common maps (Mercator projection). So some northern and southern countries may be perceived as squashed.
*/
