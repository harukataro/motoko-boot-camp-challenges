import Custom "custom";
import Animal "animal";
import List "mo:base/List";

actor{
    public type Sports = Custom.Sports;
    public type Animal = Animal.Animal;
    
    let animals: List.List<Animal> = List.nil<Animal>();

    let animal : Animal = {
        name = "" ;
        energy = 0;
    };

    public func fun(): async Sports {
        let baseball : Sports = {
            name = "baseball";
            useBall = true;
            numerOfTeamMembers = 9;
        };
        return baseball;
    };

    public func create_animal_then_takes_a_break(specie: Text, en: Nat) :async Animal{
        let animal : Animal = {
            name = specie;
            energy = en;
        };
        let ans = await Animal.animal_sleep(animal);
        return ans;
    };

    public func push_animal(animal: Animal) {
        let ans = List.push(animal, animals);
    };

    public func get_animals(): async [Animal] {
        switch(animals) {
            case (?anumals){
                List.toArray<Animal>(animals);
            };
            case(nul){
                return [];
            };
        };
    };
};