Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {

  $(".pokemon-list").append("<li class='poke-list-item' data-pokemon-id=" + pokemon.escape("id") + "><ul>" +
  "<li data-pokemon-id=" + pokemon.escape("id") + ">Name: " + pokemon.escape("name") + "</li>" +
  "<li data-pokemon-id=" + pokemon.escape("id") + ">Type: " + pokemon.escape("poke_type") + "</li>" +
  "</ul></li>");
};

Pokedex.RootView.prototype.refreshPokemon = function (callback) {
  var that = this;
  this.pokes.fetch({success:
    function(){
      that.pokes.each(function(pokemon){
        that.addPokemonToList(pokemon);
      });
    }
  });
};
