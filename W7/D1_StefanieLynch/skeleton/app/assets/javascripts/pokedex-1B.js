Pokedex.RootView.prototype.renderPokemonDetail = function (pokemon) {
  var toystring = "";
  debugger
  pokemon.toys().each(function(toy){
    toystring+= "<li>" + toy.escape("name") + "</li>";
  });

  this.$pokeDetail.html("<img src=" + pokemon.escape("image_url") + ">" +
  "<div class='detail'><ul>" +
  "<li>Name: " + pokemon.escape("name") + "</li>" +
  "<li>Type: " + pokemon.escape("poke_type") + "</li>" +
  "<li>Attack: " + pokemon.escape("attack") + "</li>" +
  "<li>Defense: " + pokemon.escape("defense") + "</li>" +
  "<li>Moves: " + pokemon.escape("moves") + "</li></ul>" +
  "<ul>" + toystring + "</ul></div>");
};

Pokedex.RootView.prototype.selectPokemonFromList = function (event) {
  var $currentTarget = $(event.target);
  var that = this;
    this.pokes.fetch({success:
      function(){
        var currentPoke = that.pokes.get($currentTarget.data("pokemon-id"));
        that.renderPokemonDetail(currentPoke);
      }
    });
  };
