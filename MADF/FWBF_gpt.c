#include <stdio.h>
#include <limits.h>

#include <stdlib.h>

#define MAX 10
#define inf INT_MAX

int cqueue_arr[MAX];
int rear=-1, front=-1;

int isFull(){
    if((front == 0 && rear == MAX-1) || front == rear + 1)
        return 1;
    else
        return 0;
}
int isEmpty(){
    if(front == -1)
        return 1;
    else
        return 0;
}
void insert(int item){
    if(isFull()){
        printf("Queue Overflow\n");
        return;
    }
    if(front == -1)
        front = 0;
    if(rear == MAX-1)
        rear = 0;
    else
        rear = rear + 1;
    cqueue_arr[rear] = item;
}
int del(){
    int item;
    if(isEmpty()){
        printf("Queue Underflow\n");
        exit(1);
    }
    item = cqueue_arr[front];
    if(front == rear){
        front = -1;
        rear = -1;
    }
    else if(front == MAX-1)
        front = 0;
    else
        front = front + 1;
    return item;
}




void printPaths(int P[MAX][MAX], int i, int j) {
    if (i == j) {
        printf("%d", i);
        return;
    }
    printPaths(P, i, P[i][j]); 
    printf("->%d", j);
}

void AllPaths(int cost[MAX][MAX], int A[MAX][MAX], int n) {
    int i, j, k;
    int P[MAX][MAX];

    printf("A 0 =  \t\t\t\t  P 0 =\n");
    for (i = 1; i <= n; i++) {
        printf("    ");
        for (j = 1; j <= n; j++) {
            A[i][j] = cost[i][j];

            if (A[i][j] == inf)
                printf("%4s ", "inf");
            else
                printf("%4d ", A[i][j]);

            P[i][j] = (i == j) ? 0 : i;
        }

        printf("         ");
        for (j = 1; j <= n; j++) {
            printf("%4d ", P[i][j]);
        }

        printf("\n");
    }
    printf("\n");

    for (k = 1; k <= n; k++) {
        printf("A %d = \t\t\t\t P %d =\n", k, k);
        for (i = 1; i <= n; i++) {
            printf("    ");
            for (j = 1; j <= n; j++) {
                if (A[i][k] != inf && A[k][j] != inf && A[i][j] > A[i][k] + A[k][j]) {
                    A[i][j] = A[i][k] + A[k][j];
                    P[i][j] = P[k][j]; 
                }
                if (A[i][j] == inf)
                    printf("%4s ", "inf");
                else
                    printf("%4d ", A[i][j]);
            }

            printf("         ");
            for (j = 1; j <= n; j++) {
                printf("%4d ", P[i][j]);
            }

            printf("\n");
        }
        printf("\n\n");
    }

    printf("Source Destin Length Path\n");
    for (i = 1; i <= n; i++) {
        for (j = 1; j <= n; j++) {
            if (i != j) {
                printf("  %2d     %2d     %2d     ", i, j, A[i][j]);
                printPaths(P, i, j);
                printf("\n");
            }
        }
    }
}

void printPath(int P[], int v, int j) {
    if (v == j) {
        printf("%d", v);
        return;
    }
    printPath(P, v, P[j]);
    printf("->%d", j);
}

void BellmanFord(int v, int costy[MAX][MAX], int dist[], int no) {
    int i, k, u;
    int P[MAX];

    for (i = 1; i <= no; i++) {
        dist[i] = costy[v][i];
        P[i] = /*(dist[i] == inf) ? -1 :*/ v;
    }

    printf("  u / i  | 1 | 2 | 3 | 4 | 5 | 6 | 7 |\n");
    printf("dist [1] |");
    for (i = 1; i <= no; i++) {
        if (dist[i] == inf)
            printf("%3s|", "inf");
        else
            printf("%2d |", dist[i]);
    }
    printf("\n");

    for (k = 1; k < no - 1; k++) {
        printf("dist [%d] |", k + 1);
        for (u = 1; u <= no; u++) {
            for (i = 1; i <= no; i++) {
                if (costy[i][u] != inf && dist[i] != inf && dist[u] > dist[i] + costy[i][u]) {
                    dist[u] = dist[i] + costy[i][u];
                    P[u] = i;

                    insert(u);    insert(i);
                }
            }
            if (dist[u] == inf)
                printf("%3s|", "inf");
            else
                printf("%2d |", dist[u]);
        }
        printf("\n");

        while(!isEmpty()){
            u = del();    i = del(); 
            printf("          ");
            printf("u = %2d, i = %2d  ", u, i);
        }
        printf("\n");
    }
    printf("\n\n");

    printf("Source Destin Length Path\n");
    for (i = 1; i <= no; i++) {
        if (i != v) {
            printf("  %2d     %2d     %2d     ", v, i, dist[i]);
            printPath(P, v, i);
            printf("\n");
        }
    }
}

int main() {
    int i,j;

    int n = 5;
    int cost[MAX][MAX], A[MAX][MAX];
    
    for (i = 1; i <= n; i++) {
        for (j = 1; j <= n; j++) {
            
            A[i][j] = (i == j) ? 0 : inf;
            cost[i][j] = (i == j) ? 0 : inf;

            /*cost[i][j] = inf;
            A[i][j] = inf;
            if (i == j) {
                cost[i][j] = 0;
                A[i][j] = 0;
            }*/
        }
    }

    cost[1][2] = 8;
    cost[1][3] = 3;
    cost[1][5] = -4;
    cost[2][1] = 2;
    cost[2][3] = -2;
    cost[2][4] = 4;
    cost[2][5] = 7;
    cost[3][2] = 2;
    cost[3][4] = 6;
    cost[4][1] = -2;
    cost[4][3] = -5;
    cost[4][5] = -2;
    cost[5][1] = 6;
    cost[5][4] = 6;

    AllPaths(cost, A, n);

    int v = 1, no = 7;
    int costy[MAX][MAX], dist[MAX];

    for (int i = 1; i <= no; i++) {
        dist[i] = inf;
        for (int j = 1; j <= no; j++) {
            costy[i][j] = inf;
            if (i == j) {
                costy[i][j] = 0;
                dist[i] = 0;
            }
        }
    }

    //j = 2*no;
    //int cqueue_arr[j];

    costy[1][2] = 6;
    costy[1][3] = 5;
    costy[1][4] = 5;
    costy[2][3] = 3;
    costy[2][5] = -1;
    costy[2][6] = 2;
    costy[2][7] = 3;
    costy[3][1] = 16;
    costy[3][2] = -2;
    costy[3][5] = 1;
    costy[4][1] = -2;
    costy[4][2] = 3;
    costy[4][3] = -2;
    costy[4][6] = -1;
    costy[5][1] = 1;
    costy[5][2] = 2;
    costy[5][6] = 5;
    costy[5][7] = 3;
    costy[6][1] = 4;
    costy[6][2] = 1;
    costy[6][7] = 3;
    costy[7][1] = -2;
    costy[7][2] = -1;
    costy[7][3] = 3;
    costy[7][6] = -2;
    
    BellmanFord(v, costy, dist, no);

    return 0;
}
