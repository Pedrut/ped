def dance(dancers, steps):
    n = len(dancers)
    direction = [1 if dancers[i][1] == 1 else -1 for i in range(n)]
    positions = [dancers[i][0] for i in range(n)]
    count = 0

    for step in range(steps):
        for i in range(n):
            for j in range(i + 1, n):
                if positions[i] == positions[j]:
                    direction[i] = -direction[i]
                    direction[j] = -direction[j]
                    count += 2
                elif positions[i] < positions[j] and direction[i] == 1:
                    direction[i] = -direction[i]
                    count += 1
                elif positions[j] < positions[i] and direction[j] == 1:
                    direction[j] = -direction[j]
                    count += 1

        for i in range(n):
            positions[i] = positions[i] + direction[i]

        if positions == [dancers[i][0] for i in range(n)] and direction == [1 if dancers[i][1] == 1 else -1 for i in
                                                                            range(n)]:
            break

    return count


dancers = [[2, 1], [3, 1], [5, 1], [6, 1]]
steps = 4
print("Number of direction changes:", dance(dancers, steps))

dancers = [[2, -1], [3, 1]]
steps = 1
print("Number of direction changes:", dance(dancers, steps))

dancers = [[2, -1], [3, 1], [4, -1], [6, 1], [7, -1], [8, 1]]
steps = 6
print("Number of direction changes:", dance(dancers, steps))
