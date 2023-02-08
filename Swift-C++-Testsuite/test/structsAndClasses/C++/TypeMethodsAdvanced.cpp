
#include <iostream>
#include <string>

struct LevelTracker {
    static int highestUnlockedLevel;
    int currentLevel;

    static void unlock(int level) {
        if (level > highestUnlockedLevel) { highestUnlockedLevel = level; }
    }

    static bool isUnlocked(int level) {
        return level <= highestUnlockedLevel;
    }

    bool advance(int level) {
        if (isUnlocked(level)) {
            currentLevel = level;
            return true;
        } else {
            return false;
        }
    }
};
int LevelTracker::highestUnlockedLevel = 1;

class Player {
public:
    LevelTracker tracker;
    std::string playerName;
    void complete(int level) {
        LevelTracker::unlock(level + 1);
        tracker.advance(level + 1);
    }
    Player(std::string name) : playerName(name) {}
};

int main() {
    Player p1("p1");
    Player p2("p2");
    p1.complete(2);
    p1.complete(1);
    return 0;
}