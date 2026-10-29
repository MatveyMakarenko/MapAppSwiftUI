import Foundation
import MapKit

class LocationsDataService {
    
    static let locations: [Location] = [
        Location(
            name: "Tomsk State University",
            cityName: "Tomsk",
            coordinates: CLLocationCoordinate2D(latitude: 56.469463, longitude: 84.947568),
            description: "National Research Tomsk State University (TSU) is a public classical research university in Tomsk, Russia, and the first institution of higher education established in the Asian part of Russia.",
            imageNames: [
                "Tomsk-TSU-1",
                "Tomsk-TSU-2"
            ],
            link: "https://en.wikipedia.org/wiki/Tomsk_State_University"),
        Location(
            name: "Vtorov Passage",
            cityName: "Tomsk",
            coordinates: CLLocationCoordinate2D(latitude: 56.484402, longitude: 84.949400),
            description: "Vtorov's Passage (A. F. Vtorov & Sons Trading House) in Tomsk is a historic three-story building designed in the Art Nouveau (Siberian Modern) style. Built between 1903 and 1905 by the prominent architect Viktor Lygin, it stands at the intersection of Lenin Avenue (formerly Pochtamskaya Street) and Batenkov Lane.",
            imageNames: [
                "Tomsk-Vtorov-1",
                "Tomsk-Vtorov-2"
            ],
            link: "https://xn--j1ancq.xn--p1ai/vtorov/about/"),
        Location(
            name: "Trevi Fountain",
            cityName: "Rome",
            coordinates: CLLocationCoordinate2D(latitude: 41.9009, longitude: 12.4833),
            description: "The Trevi Fountain is a fountain in the Trevi district in Rome, Italy, designed by Italian architect Nicola Salvi and completed by Giuseppe Pannini and several others. Standing 26.3 metres high and 49.15 metres wide, it is the largest Baroque fountain in the city and one of the most famous fountains in the world.",
            imageNames: [
                "rome-trevifountain-1",
                "rome-trevifountain-2",
                "rome-trevifountain-3",
            ],
            link: "https://en.wikipedia.org/wiki/Trevi_Fountain"),
        Location(
            name: "Novosibirsk State University",
            cityName: "Novosibirsk",
            coordinates: CLLocationCoordinate2D(latitude: 54.846, longitude: 83.094),
            description: "Novosibirsk State University (NSU) is a premier public research university in Russia, founded in 1958 in the Akademgorodok scientific hub near Novosibirsk.",
            imageNames: [
                "Novosib-NSU-1",
                "Novosib-NSU-2"
            ],
            link: "https://en.wikipedia.org/wiki/Novosibirsk_State_University"),
        Location(
            name: "Novosibirsk Opera and Ballet Theatre",
            cityName: "Novosibirsk",
            coordinates: CLLocationCoordinate2D(latitude: 55.03028, longitude: 82.92472),
            description: "The Novosibirsk State Academic Opera and Ballet Theatre (widely known as NOVAT) is the largest and most architecturally significant theatre building in Russia, located in the heart of Novosibirsk at Lenin Square (36 Krasny Prospekt).",
            imageNames: [
                "Novosib-Theatre-1",
                "Novosib-Theatre-2"
            ],
            link: "https://en.wikipedia.org/wiki/Novosibirsk_Opera_and_Ballet_Theatre"),
        Location(
            name: "Eiffel Tower",
            cityName: "Paris",
            coordinates: CLLocationCoordinate2D(latitude: 48.858056, longitude: 2.294444),
            description: "The Eiffel Tower is a wrought-iron landmark located in the center of Paris, France. Designed by engineer Gustave Eiffel, it was constructed between 1887 and 1889 as the entrance arch for the 1889 World's Fair, which celebrated the centenary of the French Revolution.",
            imageNames: [
                "paris-eiffeltower-1",
                "paris-eiffeltower-2"
            ],
            link: "https://en.wikipedia.org/wiki/Eiffel_Tower"),
    ]
    
}
