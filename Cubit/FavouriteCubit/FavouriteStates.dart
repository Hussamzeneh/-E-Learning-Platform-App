abstract class FavouriteStates {}

class InitialState extends FavouriteStates {}

class FavouriteAdded extends FavouriteStates {
  final String id;
  FavouriteAdded(this.id);
}

class FavouriteRemoved extends FavouriteStates {
  final String id;
  FavouriteRemoved(this.id);
}

class FavouritesLoaded extends FavouriteStates {
  final List<String> favourites;
  FavouritesLoaded(this.favourites);
}

class FavouriteError extends FavouriteStates {
  final String error;
  FavouriteError(this.error);
}

class Sucsesfavbook extends FavouriteStates{}
class Loadingfavbook extends FavouriteStates{}
class feuliurfavbook extends FavouriteStates{}
class Sucsesfavteacher extends FavouriteStates{}
class Loadingfavteacher extends FavouriteStates{}
class feuliurfavteacher extends FavouriteStates{}