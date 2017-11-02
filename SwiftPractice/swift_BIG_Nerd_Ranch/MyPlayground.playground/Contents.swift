import Foundation

let volunteerCounts = [1,3,40,32,2,53,77,13]

let volunteerSorted = volunteerCounts.sorted(by: { i, j in i < j })
volunteerSorted

func makeTownGrand(withBudget budget: Int,
                   condition: (Int) -> Bool) -> ((Int, Int) -> Int)? {
    if condition(budget){
        func buildRoads(byAddingLights lights: Int,
                        toExistingLights existingLights: Int) -> Int {
            return lights + existingLights
        }
        return buildRoads
    }else {
        return nil
    }
}

func evaluate(budget: Int) -> Bool {
    return budget > 10_000
}

var stoplights = 4

if let townPlanByAddingLightsToExistingLights = makeTownGrand(withBudget: 1_000, condition: evaluate){
    stoplights = townPlanByAddingLightsToExistingLights(4, stoplights)
}

if let newTownPlanByAddingLightsToExistingLights = makeTownGrand(withBudget: 10_500, condition: evaluate){
    stoplights = newTownPlanByAddingLightsToExistingLights(4, stoplights)
}

func makePopulationTracker(forInitialPopulation population: Int) -> (Int) -> Int {
    var totalPopulation = population
    func populationTracker(growth: Int) -> Int{
        totalPopulation += growth
        return totalPopulation
    }
    return populationTracker
}

var currentPopulation = 5_422

let growBy = makePopulationTracker(forInitialPopulation: currentPopulation)
growBy(500)

currentPopulation = growBy(50)
let anotherGrowBy = growBy
anotherGrowBy(500)

currentPopulation

var bitCityPopulation = 4_609_982
let bitCityGrowBy = makePopulationTracker(forInitialPopulation: bitCityPopulation)
bitCityPopulation = bitCityGrowBy(10_000)

currentPopulation

let precinctPopulations = [1244, 2021, 2157]
//let projectedPopulations = precinctPopulations.map{ (population: Int) -> Int in return population*2}
let projectedPopulations = precinctPopulations.map({ population in population * 2 })
projectedPopulations

let bigProjections = projectedPopulations.filter({ projection in projection > 4000 })
bigProjections

let totalProjection = projectedPopulations.reduce(0){ (accmulatedProjection: Int, precintProjection: Int) -> Int in return accmulatedProjection + precintProjection }

totalProjection
