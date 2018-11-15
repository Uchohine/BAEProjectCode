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
    const int sampleTime = 256;
    const double f1 = 500;// frequency for bit 00
    const double f2 = 1500;// frequency for bit 01
    const double f3 = 2500;// frequency for bit 10
    const double f4 = 3500;// frequency for bit 11
    const double A = 1;//amplitude
    const double PI = std::atan2(0, -1);
    std::ofstream out;
    out.open("Signal.dat");
    const double fs = 10000;
    const double T = 1/fs;
    bool proceed = true;
    while(!input.empty())
    {
        std::string a = input.substr(0, 2);
        input = input.substr(2, input.back());
        if(proceed)
        {
            if(a == "00")
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
            else if(a == "01")
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
            else if(a == "10")
            {
                double Fstart = 0;
                for(int start = 0; start != sampleTime; ++start)
                {
                    double x = 2 * f3 * PI * Fstart;
                    float y = A * std::cos(x);
                    out << y << std::endl;
                    Fstart += T;
                }
            }
            else if(a == "11")
            {
                double Fstart = 0;
                for(int start = 0; start != sampleTime; ++start)
                {
                    double x = 2 * f4 * PI * Fstart;
                    float y = A * std::cos(x);
                    out << y << std::endl;
                    Fstart += T;
                }
            }
            else
            {
                std::cout << "ERROR INPUT" << std::endl;
                proceed = false;
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
