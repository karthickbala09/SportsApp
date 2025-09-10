import 'appscreens/missionclass.dart';


Map<String, Map<String, List<Mission>>> missionsData = {
  "Athletics": {
    "Easy": List.generate(
        20,
            (index) => Mission(
            id: index,
            title: "Mission ${index + 1}",
            description: "Take ${10 + index} situps")),
    "Medium": List.generate(
        20,
            (index) => Mission(
            id: index,
            title: "Mission ${index + 1}",
            description: "Run for ${100 + index * 10} meters")),
    "Pro": List.generate(
        20,
            (index) => Mission(
            id: index,
            title: "Mission ${index + 1}",
            description: "Hold plank for ${30 + index * 5} seconds")),
  },
  "Swimming": {
    "Easy": List.generate(
        20,
            (index) => Mission(
            id: index,
            title: "Mission ${index + 1}",
            description: "Practice breathing for ${5 + index} mins")),
    "Medium": List.generate(
        20,
            (index) => Mission(
            id: index,
            title: "Mission ${index + 1}",
            description: "Swim ${50 + index * 5} meters")),
    "Pro": List.generate(
        20,
            (index) => Mission(
            id: index,
            title: "Mission ${index + 1}",
            description: "Perform turns and starts practice")),
  },
  // Add more sports as needed
};
