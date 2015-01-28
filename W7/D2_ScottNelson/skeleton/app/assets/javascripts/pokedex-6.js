Pokedex.Router = Backbone.Router.extend({
  routes: {
    "": "pokemonIndex",
    "pokemon/:id": "pokemonDetail",
    "pokemon/:pokemonId/toys/:toyId": "toyDetail"
  },

  pokemonDetail: function (id, callback) {
    this.pokemonIndex( function(){
      var pokemon = this._pokemonIndex.collection.get(id);
      var pokeView = new Pokedex.Views.PokemonDetail({model: pokemon});
      var pokeDetail = $("#pokedex .pokemon-detail");
      pokeDetail.empty();
      pokeDetail.append(pokeView.$el);
      pokeView.refreshPokemon();
      console.log("about to call toy callback");
      callback && callback();
    }.bind(this));

    return this;
  },

  pokemonIndex: function (callback) {

    var pokemonIndex = new Pokedex.Views.PokemonIndex();
    if (typeof this._pokemonIndex === "undefined"){
      this._pokemonIndex = pokemonIndex;
    }
    pokemonIndex.refreshPokemon({success: callback});

    $("#pokedex .pokemon-list").html(pokemonIndex.$el);
  },

  toyDetail: function (pokemonId, toyId) {
    var that = this;
    var toy = this._pokemonIndex.collection.get(pokemonId).toys().get(toyId);

    this.pokemonDetail(pokemonId, function() {
      debugger
      console.log("In toy callback, the toy: ");
      console.log(toy);
      var toyView = new Pokedex.Views.ToyDetail({model: toy});
      var toyDetail = $("#pokedex .toy-detail");
      toyDetail.html(toyView.$el);
      toyView.render();
    }.bind(this))

    return this;
  },

  pokemonForm: function () {
  }
});


$(function () {
  new Pokedex.Router();
  Backbone.history.start();
});
