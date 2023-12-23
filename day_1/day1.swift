import Foundation

class Day1 {

    let NUMBERS_DICT: [String : String] = [
        "one" : "o1e",
        "two": "t2o",
        "three" : "t3e",
        "four" : "f4r",
        "five" : "f5e",
        "six" : "s6x",
        "seven" : "s7n",
        "eight" : "e8t",
        "nine" : "n9e"
	]

	var input: [String] = []

	init() {
        solveDayOne_1()
		solveDayOne_2()
	}

	func solveDayOne_1() {
		let input = getInput()
		let formattedValues = formatNumbers(filterLeters(input: input))
		addCalibrationValues(formattedValues)
	}

	func solveDayOne_2() {
		let input = getInput()
        let cleanedInput = convertWordsToNumbers(values: input)
        let filteredInput = filterLeters(input: cleanedInput)
        let formattedValues = formatNumbers(filteredInput)
        addCalibrationValues(formattedValues)
	}
}

private extension Day1 {
	func filterLeters(input: [String]) -> [String] {
		var filteredValues: [String] = []
		input.filter({ !$0.isEmpty })
			.forEach { value in
				let sanitizedValue =
					value.components(
						separatedBy: CharacterSet.decimalDigits.inverted
					)
					.joined()
				filteredValues.append(sanitizedValue)
			}
		return filteredValues
	}

	func formatNumbers(_ values: [String]) -> [Int] {
		var calibrationValues: [Int] = []
		values.forEach { value in
			var formattedValue: String = ""
			if value.count <= 1 {
				formattedValue = value + value
			} else {
				if let fistDigit = value.first, let lastDigit = value.last {
					formattedValue = String(fistDigit) + String(lastDigit)
				}
			}
			guard let numericValue = Int(formattedValue) else { return }
			calibrationValues.append(numericValue)
		}
		return calibrationValues
	}

	func addCalibrationValues(_ values: [Int]) {
		var calibrationValue: Int = 0
		values.forEach { value in
			calibrationValue = calibrationValue + value
		}
		print(calibrationValue)
	}

	func getInput() -> [String] {
		guard let url = Bundle.module.url(forResource: "input", withExtension: "txt") else {
			return []
		}
		do {
			let input = try String(contentsOf: url)
			return input.components(separatedBy: "\n")
		} catch {
			print(error.localizedDescription)
			return []
		}
	}

	private func convertWordsToNumbers(values: [String]) -> [String] {
        var result: [String] = []
		values.forEach { value in
            var newValue: String = value
			NUMBERS_DICT.forEach { number in
                if newValue.contains(number.key) {
                    newValue = newValue.replacingOccurrences(of: number.key, with: number.value)
                }
			}
            result.append(newValue)
		}
        return result
	}
}
