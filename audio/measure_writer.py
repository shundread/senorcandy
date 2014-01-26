#!/usr/bin/python

import sys

import pygame
from pygame.mixer import music

class Twerk(object):
    def __init__(self, start, stop, count, policy):
        self.start = start
        self.stop = stop
        self.count = count
        self.policy = policy

    @property
    def length(self):
        return (self.stop - self.start)

    def toQML(self):
        return "{" + "start: {0}, end: {1}, twerkGoal: {2}, twerkPolicy: {3}".format(
            self.start, self.stop, self.count, self.policy) + "},"


    def __str__(self):
        return "Twerk: {0} - {1} (length: {2}), count: {3}".format(self.start, self.stop, self.length, self.count)

def countTwerkIntervals(twerkList):
    for t in range(len(twerkList)-1):
        print("twerkLength length: {0}".format(twerkList[t+1].start - twerkList[t].stop))

def main():
    if len(sys.argv) != 4:
        print("usage:\n\t{0} MUSIC_FILE TWERK_LENGTH PAUSE_LENGTH")
        sys.exit(1)

    twerkLength = int(sys.argv[2])
    pauseLength = int(sys.argv[3])
    pygame.init()
    pygame.display.set_mode((10, 10))

    twerkLeft = int(twerkLength*0.5)
    twerkRight = int(twerkLength*0.5)

    music.load(sys.argv[1])


    print("Ready to go, press ESCAPE to stop")
    music.play()

    pygame.event.set_blocked(None)
    pygame.event.set_allowed([pygame.KEYDOWN, pygame.KEYUP])

    twerkList = []

    while True:
        keysdown = pygame.event.get(pygame.KEYDOWN)
        keysup = pygame.event.get(pygame.KEYUP)
        if pygame.key.get_pressed()[pygame.K_ESCAPE]:
            break

        if keysdown:
            stamp = music.get_pos()
            if pygame.key.get_pressed()[pygame.K_d]:
                twerkList.append(Twerk(stamp-twerkLeft, stamp+twerkRight, 1, 3))
            else:
                twerkList.append(Twerk(stamp-twerkLeft, stamp+twerkRight, 1, 1))

    if len(twerkList) == 0:
        return

    print("Twerks:")
    for twerk in twerkList:
        print(twerk)

    print("\nTwerk twerkLengths")
    countTwerkIntervals(twerkList)

    compressedTwerks = [twerkList[0]]
    for twerk in twerkList[1:]:
        if twerk.start <= compressedTwerks[-1].stop:
            compressedTwerks[-1].stop = twerk.stop
            compressedTwerks[-1].count += 1
        else:
            compressedTwerks.append(twerk)

    print("\nCompressed Twerks:")
    for twerk in compressedTwerks:
        print(twerk)

    print("\nCompressed Twerks twerkLengths")
    countTwerkIntervals(compressedTwerks)

    print("\nFinal intervals")
    t = Twerk(0, compressedTwerks[0].start, 0, 0)
    print(t.toQML())
    for n, t in enumerate(compressedTwerks):
        print(t.toQML())
        if n < len(compressedTwerks) -1:
            if compressedTwerks[n+1].start - t.stop < pauseLength:
                gap = Twerk(t.stop, compressedTwerks[n+1].start, 1, 2)
            else:
                gap = Twerk(t.stop, compressedTwerks[n+1].start, 1, 0)
            print(gap.toQML())

if __name__=="__main__":
    main()
