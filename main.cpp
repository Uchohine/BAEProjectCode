//
//  main.cpp
//  Signal Generator
//
//  Created by Ming Wen on 11/14/18.
//  Copyright © 2018 Ming Wen. All rights reserved.
//

#include <iostream>
#include <cmath>
#include <fstream>
#include <string>

int main(int argc, const char * argv[]) {
    // insert code here...
    std::string input = argv[1];
    const int sampleTime = 32;
    const double f1 = 1500;// frequency for bit 1
    const double f2 = 2000;// frequency for bit 0
    const double A = 1;//amplitude
    const double PI = std::atan2(0, -1);
    std::ofstream out;
    out.open("Signal.dat");
    const double fs = 16000;
    const double T = 1/fs;
    bool proceed = true;
    for(auto a : input)
    {
        if(proceed)
        {
            switch (a) {
                case '1':
                {
                    double Fstart = 0;
                    for(int start = 0; start != sampleTime; ++start)
                    {
                        double x = 2 * f1 * PI * Fstart;
                        float y = A * std::cos(x);
                        out << y << std::endl;
                        Fstart += T;
                    }
                }
                    break;
                case '0':
                {
                    double Fstart = 0;
                    for(int start = 0; start != sampleTime; ++start)
                    {
                        double x = 2 * f2 * PI * Fstart;
                        float y =  A * std::cos(x);
                        out << y << std::endl;
                        Fstart += T;
                    }
                }
                    break;
                default:
                {
                    std::cout << "ERROR INPUT" << std::endl;
                    proceed = false;
                }
                    break;
            }
        }
        else
        {
            break;
        }
    }
    out << fs <<std::endl;
    out.close();
    return 0;
}
