
int main() {
    auto photos = listPhotos("home");
    return 0;
}

std::vector<std::string> listPhotos(const std::string &name) {
  std::vector<std::string> result = {"MyPhotoNames"};  // ... some asynchronous networking code ...
  std::this_thread::sleep_for(std::chrono::seconds(2));
  return result;
}