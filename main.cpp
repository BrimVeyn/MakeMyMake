/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.cpp                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: bvan-pae <bryan.vanpaemel@gmail.com>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/03/21 11:41:26 by bvan-pae          #+#    #+#             */
/*   Updated: 2024/03/22 14:10:40 by bvan-pae         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <fstream>
#include <vector>
#include <iostream>
#include <filesystem>
#include <string>

namespace fs = std::filesystem;

std::vector<std::string> findCppFiles(const std::string& directory, char **av) {

	std::vector<std::string> tab;

    for (const auto& entry : fs::directory_iterator(directory)) {
        if (entry.is_regular_file() && entry.path().extension() == ".cpp") {
            tab.push_back(av[2] / entry.path().filename());
        }
    }
	return tab;
}

int main(int ac, char **av)
{
	if (ac != 3 && ac != 4)
	{
		std::cerr << "Error: usage: ./mmm <input makefile> <srcs directory> {custom source name}" <<std::endl;
		return 1;
	}
	std::ifstream inputFile(av[1]);
	if (!inputFile)
	{
		std::cerr << "Error: could not open input file" <<std::endl;
		return 1;
	}
	std::ofstream outputFile("Makefile.result");
	if (!outputFile)
	{
		std::cerr << "Error: could not open output file" <<std::endl;
		return 1;
	}

	std::vector<std::string> v = {"SRC", "SRCS", "SOURCE", "SOURCES"};

	if (ac == 4)
		v.push_back(av[3]);

	fs::path directory = fs::current_path();
	directory /= av[2];
	std::cout << "path = " << directory << std::endl;

	std::vector<std::string> userSrcs = findCppFiles(directory, av);
	if (!userSrcs.size())
	{
		std::cerr << "Error reading directory" << std::endl;
	}

	std::string tmp;
	int stop = 0;
	int printOut = 0;

	while(std::getline(inputFile, tmp))
	{
		printOut = 0;
		for(const std::string& substr : v){
			if (tmp.find(substr) != std::string::npos && !stop){
				std::string newSrcs = tmp.substr(0, substr.size());
				newSrcs += "\t:= ";
				for (size_t i = 0; i < userSrcs.size(); i++){
					if (i == 0)
						newSrcs += "\t" + userSrcs[i] + " \\\n";
					else
						newSrcs+= "\t\t" + userSrcs[i] + " \\\n";
				}
				outputFile << newSrcs << std::endl;
				stop = 1;
				printOut = 1;
			}
		}
		if (!printOut)
			outputFile << tmp << std::endl;
		
	}

	inputFile.close();
	outputFile.close();
}
