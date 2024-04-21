//Question 4
//Assume all method calls work fine. Fix the memory leak issue in below method

/*void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
 {
Player* player = g_game.getPlayerByName(recipient);

if (!player) {

player = new Player(nullptr);

if (!IOLoginData::loadPlayerByName(player, recipient)) {
return; //No cleanup
}

}

Item* item = Item::CreateItem(itemId);

if (!item) {

    return; //If player isn't found the item doesn't cleanup

}

g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

if (player->isOffline()) {

    IOLoginData::savePlayer(player); //No deletion of allocated players
}
} */

//Looks like the memory leak is caused by the way objects are assigned to Player.
void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId) {
    Player* player = g_game.getPlayerByName(recipient);
    // Flag to indicate if the player was dynamically allocated
    bool createdNewPlayer = false;
    if (!player) {
        // Create a new player if not found
        player = new Player(nullptr);
        createdNewPlayer = true; // Mark that we've created a new player
        // Try to load player by name, clean up if it fails
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; // Prevent memory leak by deleting the dynamically allocated player
            return;
        }
    }
    Item* item = Item::CreateItem(itemId);
    if (!item) {
        if (createdNewPlayer) {
            delete player; // Clean up player if item creation fails
        }
        return;
    }
    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);
    // Check if the player is marked as offline and save if necessary
    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }
    // Clean up the dynamically created player after saving if applicable
    if (createdNewPlayer) {
        delete player; // Delete to prevent memory leaks
    }
}
