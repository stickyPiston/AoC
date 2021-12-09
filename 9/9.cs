using System;
using System.IO;
using System.Linq;
using System.Collections.Generic;

// Credit to Sem, who i did this challenge with today

namespace SmokeBasin
{
    class Program
    {
        static byte[] Matrix;
        static void Main(string[] args)
        {
            Matrix = File.ReadAllBytes("9.txt");
            Matrix = Matrix.Where((b)=> b != '\n').ToArray();
            Matrix = Matrix.Select((b)=> (byte)(b - 48)).ToArray();
            List<(int,byte)> LowestPoint =  new List<(int, byte)>();

            for (int i = 0; i < Matrix.Length; i++)
            {
                bool IsLowest = true;
                if (i % 100 != 0 && Matrix[i-1] <= Matrix[i])
                    IsLowest = false;
                if (i % 100 != 99 && Matrix[i+1] <= Matrix[i])
                    IsLowest =  false;
                if (i >= 100 && Matrix[i - 100] <= Matrix[i])
                    IsLowest = false;
                if (i < Matrix.Length - 100 && Matrix[i+100] <= Matrix[i])
                    IsLowest = false;
                if (IsLowest)
                    LowestPoint.Add((i,Matrix[i]));
            }

            int Sum = 0;
            var Basins = new List<List<int>>();
            foreach (var (i, b) in LowestPoint)
            {
                Sum += b + 1;
                Basins.Add(FormBasin(i, new List<int>()).Distinct().ToList());
            }
            Console.WriteLine(Sum);

            var Sizes = Basins.Select((b)=> b.Count());
            var BasinSize = Sizes.OrderBy((a)=>a).Reverse().Take(3);
            int Result = 1;
            foreach(var b in BasinSize)
            {
                Result *= b;
            }
            Console.WriteLine(Result);
        }

        static List<int> FormBasin(int i, List<int> visisted)
        {
            List<int> BasinPositions = new List<int>();
            BasinPositions.Add(i);
            if (i % 100 != 0 && !visisted.Contains(i-1) && Matrix[i-1] != 9)
            {
                visisted.Add(i);
                BasinPositions = BasinPositions.Concat(FormBasin(i-1, visisted)).ToList();
            }
            if (i % 100 != 99 && !visisted.Contains(i+1) && Matrix[i+1] != 9)
            {
                visisted.Add(i);
                BasinPositions = BasinPositions.Concat(FormBasin(i+1, visisted)).ToList();
            }
            if (i >= 100 && !visisted.Contains(i-100) && Matrix[i-100] != 9)
            {
                visisted.Add(i);
                BasinPositions = BasinPositions.Concat(FormBasin(i-100, visisted)).ToList();
            }
            if (i < Matrix.Length - 100 && !visisted.Contains(i+100) && Matrix[i+100] != 9)
            {
                visisted.Add(i);
                BasinPositions = BasinPositions.Concat(FormBasin(i+100, visisted)).ToList();
            }
            return BasinPositions;
        }
    }
}
