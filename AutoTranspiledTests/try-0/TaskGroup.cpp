
struct MyMain {
    static void withTaskGroup(std::vector <std::string> taskGroup) {
        std::vector<std::future<std::vector<std::string>>> futureTasks;
        std::vector<std::string> photoNames = listPhotos("Summer Vacation");
        for (auto name : photoNames) {
            futureTasks.push_back(std::async(downloadPhoto, name));
        }
        for (auto &task : futureTasks) {
            std::vector<std::string> downloadResult = task.get();
        }
    }

    static std::vector<std::string> downloadPhoto(std::string name) {
        std::vector<std::string>result = {"MyPhoto" }; // ... some asynchronous networking code
        std::this_thread::sleep_for(std::chrono::seconds(2));
        return result;
    }

    static std::vector<std::string> listPhotos(std::string name) {
        std::vector<std::string>result = {"MyPhotoNames"}; // ... some asynchronous networking code
        std::this_thread::sleep_for(std::chrono::seconds(2));
        return result;
    }
};