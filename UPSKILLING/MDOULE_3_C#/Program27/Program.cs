using System;
using System.Threading;

class Program
{
    static readonly object lock1 = new object();
    static readonly object lock2 = new object();

    static void Thread1()
    {
        bool gotLock1 = false;
        bool gotLock2 = false;

        try
        {
            Monitor.TryEnter(lock1, 1000, ref gotLock1);

            if (gotLock1)
            {
                Console.WriteLine("thread 1 acquired lock1");

                Thread.Sleep(500);

                Monitor.TryEnter(lock2, 1000, ref gotLock2);

                if (gotLock2)
                {
                    Console.WriteLine("thread 1 acquired lock2");
                }
                else
                {
                    Console.WriteLine("thread 1 could not acquire lock2");
                }
            }
        }
        finally
        {
            if (gotLock2) Monitor.Exit(lock2);
            if (gotLock1) Monitor.Exit(lock1);
        }
    }

    static void Thread2()
    {
        bool gotLock2 = false;
        bool gotLock1 = false;

        try
        {
            Monitor.TryEnter(lock2, 1000, ref gotLock2);

            if (gotLock2)
            {
                Console.WriteLine("thread 2 acquired lock2");

                Thread.Sleep(500);

                Monitor.TryEnter(lock1, 1000, ref gotLock1);

                if (gotLock1)
                {
                    Console.WriteLine("thread 2 acquired lock1");
                }
                else
                {
                    Console.WriteLine("thread 2 could not acquire lock1");
                }
            }
        }
        finally
        {
            if (gotLock1) Monitor.Exit(lock1);
            if (gotLock2) Monitor.Exit(lock2);
        }
    }

    static void Main()
    {
        Thread t1 = new Thread(Thread1);
        Thread t2 = new Thread(Thread2);

        t1.Start();
        t2.Start();

        t1.Join();
        t2.Join();

        Console.WriteLine("program completed without deadlock");
    }
}