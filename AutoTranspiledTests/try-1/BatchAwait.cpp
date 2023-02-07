
 #include <future>
#include <vector>
#include <string>

void listPhotos(std::future<std::vector<std::string>> &inGallery, std::string name) {
	// ... some asynchronous networking code ...
	inGallery.set_value( {"MyPhotoNames"} );

	try {
		std::this_thread::sleep_for(std::chrono::seconds(2));
	} catch(const std::exception& e) {
		std::cout << "Sleep failed" << '\n';
	}
}

int main()
{
    std::future<std::vector<std::string>> firstPhoto;
	std::future<std::vector<std::string>> secondPhoto;
	std::future<std::vector<std::string>> thirdPhoto;

	listPhotos(firstPhoto, "first");
	listPhotos(secondPhoto, "second");
	listPhotos(thirdPhoto, "third");

	std::vector<std::vector<std::string>> photos;
	
	photos.push_back(firstPhoto.get());
	photos.push_back(secondPhoto.get());
	photos.push_back(thirdPhoto.get());

}