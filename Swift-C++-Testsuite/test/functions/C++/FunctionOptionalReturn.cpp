#include <optional>

	static std::optional<int> identity(int x)
	{
		if (x == 0)
		{
			return std::optional<int>{x};
		}
		return std::nullopt;
	}

int main()
{
	std::optional<int> myNil = identity(42); 
	std::optional<int> myIdentity = identity(0);
	return 0;
}