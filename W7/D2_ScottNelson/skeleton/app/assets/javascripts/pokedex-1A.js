Pokedex.RootView.prototype.addPokemonToList = function (pokemon) {
  var poke =  new Pokedex.Models.Pokemon(pokemon.get('id'));
  poke.set('id', pokemon.get('id'));

  var that = this;
  poke.fetch({
    success: function(){
      var content = JST["pokemonDetail"]({"pokemon": pokemon});
      that.$pokeList.append(content);
    },
    error: function(){
      console.log("Error!");
    }
  });
};

Pokedex.RootView.prototype.refreshPokemon = function () {
  this.pokes.fetch({
    success: (function () {
      this.$pokeList.empty();
      this.pokes.each(this.addPokemonToList.bind(this));
    }).bind(this)
  });

  return this.pokes;
};
