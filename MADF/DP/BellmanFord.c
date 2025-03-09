#include<stdio.h>
#include<stdlib.h>
#define MAX 20
#define inf 999999

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

int FindAndReplace(int u,int i){
    int j;
    for(j = front; j <= rear; j++){
        if(cqueue_arr[j] == u){
            cqueue_arr[j+1] = i;
            return 0;
        }
    }
    return 1;
}

void printPath(int P[], int v, int j) {
    if (v == j) {
        printf("%d", v);
        return;
    }
    printPath(P, v, P[j]);
    printf("->%d", j);
}

void BellmanFord(int v, int cost[MAX][MAX], int dist[], int n) {
    int i, k, u;
    int P[MAX];

    for (i = 1; i <= n; i++) {
        dist[i] = cost[v][i];
        P[i] = v;
    }
    printf("  u / i  | 1 | 2 | 3 | 4 | 5 | 6 | 7 |\n");
    printf("dist [1] |");
    for (i = 1; i <= n; i++) {
        if (dist[i] == inf)
            printf("%3s|", "inf");
        else
            printf("%2d |", dist[i]);
    }
    printf("\n");

    for (k = 1; k < n - 1; k++) {
        printf("dist [%d] |", k + 1);
        for (u = 1; u <= n; u++) {
            for (i = 1; i <= n; i++) {
                if (cost[i][u] != inf && dist[i] != inf && dist[u] > dist[i] + cost[i][u]) {
                    dist[u] = dist[i] + cost[i][u];
                    P[u] = i;
                    if(FindAndReplace(u,i)){
                        insert(u);    insert(i);
                    }
                }
            }
            if (dist[u] == inf)
                printf("%3s|", "inf");
            else
                printf("%2d |", dist[u]);
        }
        //printf("\n");
        //printf("          ");
        printf("    ");

        while(!isEmpty()){
            u = del();    i = del(); 
            printf("u = %-2d, i = %-2d    ", u, i);
        }
        printf("\n");
    }
    printf("\n\n");

    printf("Source Destin Length Path\n");
    for (i = 1; i <= n; i++) {
        if (i != v) {
            printf("  %2d     %2d     %2d     ", v, i, dist[i]);
            printPath(P, v, i);
            printf("\n");
        }
    }
}

int main(){
    int v,n;
    /*printf("Enter the number of vertices: ");
    scanf("%d",&n);

    int cost[n][n],dist[n];
    printf("Enter the cost matrix:\n");
    for(int i=0;i<n;i++){
        dist[i]=inf;
        for(int j=0;j<n;j++){
            if(i==j){                
            cost[i][j]=0;
        }
            cost[i][j]=inf;
            scanf("%d",&cost[i][j]);
            if(cost[i][j]==0 && i!=j){
                cost[i][j]=inf;
            }
        }
    }*/
    
    //printf("Enter the starting (source) vertex: ");
    //scanf("%d",&v);    
    
    n=7,v=1;
    int dist[n];
    int cost[MAX][MAX];

    for (int i = 1; i <= n; i++) {
        for (int j = 1; j <= n; j++) {
            cost[i][j] = (i == j) ? 0 : inf;
        }
    }
    
    cost[1][2] = 6;
    cost[1][3] = 5;
    cost[1][4] = 5;
    cost[2][3] = 3;
    cost[2][5] = -1;
    cost[2][6] = 2;
    cost[2][7] = 3;
    cost[3][1] = 16;
    cost[3][2] = -2;
    cost[3][5] = 1;
    cost[4][1] = -2;
    cost[4][2] = 3;
    cost[4][3] = -2;
    cost[4][6] = -1;
    cost[5][1] = 1;
    cost[5][2] = 2;
    cost[5][6] = 5;
    cost[5][7] = 3;
    cost[6][1] = 4;
    cost[6][2] = 1;
    cost[6][7] = 3;
    cost[7][1] = -2;
    cost[7][2] = -1;
    cost[7][3] = 3;
    cost[7][6] = -2;
    
    BellmanFord(v,cost,dist,n);
    
    return 0;
}
