//
//  ViewController.m
//  SortData
//
//  Created by shuanghui xu on 2018/1/9.
//  Copyright © 2018年 shuanghui xu. All rights reserved.
//

#import "ViewController.h"

typedef struct Data {
    int data;
    struct Data * nextPoint;
}LinkData;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1
    
    int A[] = {9,8,7,6,5,4,3,2,1};
    int n = sizeof(A) / sizeof(int);
    
    insertSort(A,n);
    
//    quickSort(A, 0, n-1);
    
    for (int i = 0; i < n; i ++) {
        printf("%d",A[i]);
    }
    
//    linkDemo();
    
}

void swap(int A[], int i, int j)
{
    int temp = A[i];
    A[i] = A[j];
    A[j] = temp;
}

#pragma mark - 冒泡排序  O(n^2)
void bubbleSort(int A[],int n) {
    for (int i = 0; i < n-1; i ++) { //i为已排序个数
        for (int j = 0; j < n-1-i; j ++) {// 依次比较相邻的两个元素,使较大的那个向后移
            if (A[j] > A[j+1]) {
                swap(A, A[j], A[j+1]);
            }
        }
    }
    
}
#pragma mark - 选择排序 O(n^2)
//冒泡排序通过依次交换相邻两个顺序不合法的元素位置，从而将当前最小（大）元素放到合适的位置；
//而选择排序每遍历一次都记住了当前最小（大）元素的位置，最后仅需一次交换操作即可将其放到合适的位置

void selectionSort(int A[],int n) {
    for (int i = 0; i < n-1; i ++) {
        int min = i;
        for (int j = i+1; j < n-1; j ++) { //循环一轮，标记最小的序号
            if (A[j] < A[min]) {
                min = j;
            }
        }
        if (i != min) {
            swap(A, i, min);
        }
    }
}


#pragma mark - 插入排序 O(n^2)
//1.从第一个元素开始，该元素可以认为已经被排序
//2.取出下一个元素，在已经排序的元素序列中从后向前扫描
//3.如果该元素（已排序）大于新元素，将该元素移到下一位置
//4.重复步骤3，直到找到已排序的元素小于或者等于新元素的位置
//5.将新元素插入到该位置后
//6.重复步骤2~5
void insertSort(int A[], int n ) {
    for (int i = 1; i < n; i ++) {
        int get = A[i];//取出新元素
        int j = i-1;//已经排序元素
        while (A[j] > get && j >= 0) {//依次比较，已经排序元素>新元素,且已排序个数大于0
            A[j+1] = A[j];//右移+1
            j--;
        }
        A[j+1] = get;
    }
}

#pragma mark = 快速排序 O(nlogn)-TopK
//1.从序列中挑出一个元素，作为"基准"(pivot).
//2.把所有比基准值小的元素放在基准前面，所有比基准值大的元素放在基准的后面（相同的数可以到任一边），这个称为分区(partition)操作。
//3.对每个分区递归地进行步骤1~2，递归的结束条件是序列的大小是0或1，这时整体已经被排好序了。

int  partition(int A[],int left,int right) {
    int base = A[right];
    int tail = left;
    for (int i = left; i < right; i ++) {
        if (A[i] < base) {
            swap(A, tail++, i);
        }
    }
    swap(A, tail, right);
    return tail;
}

void quickSort(int A[], int left, int right) {
    if (left >= right) {
        return;
    }
    int center = partition(A, left, right);
    quickSort(A, 0, center-1);
    quickSort(A, center+1, right);
    
}


#pragma mark - 堆排序 O(nlogn)-TopK
//1.由输入的无序数组构造一个最大堆，作为初始的无序区
//2.把堆顶元素（最大值）和堆尾元素互换
//3.把堆（无序区）的尺寸缩小1，并调用heapify(A, 0)从新的堆顶元素开始进行堆调整
//4.重复步骤2，直到堆的尺寸为1

void heapSort(int A[],int size) {
    buildHeap(A, size);
    while (size>1) {
        swap(A, 0, --size);//堆顶与最后一个数交换
        heapify(A, 0, size);//重新从堆顶向下开始调整最大堆
    }
}

void buildHeap(int A[], int size) {//创建最大堆
    for (int i = size/2-1; i >= 0; i --) {  // 从每一个非叶结点开始向下进行堆调整  （size/2-1）
        heapify(A, i, size);
    }
}

void heapify(int A[],int i,int size) { //调整堆结构，从A[i]开始向下排序
    int left = 2*i+1;
    int right = 2*i+2;
    int max = i;
    if (left < size && A[max] < A[left]) {
        max = left;
    }
    if (right < size && A[max] < A[right]) {
        max = right;
    }
    if (i != max) {
        swap(A, i, max);//交换
        heapify(A,max,size);//继续向下排序
    }
    
}




#pragma mark - 冒泡排序改进，鸡尾酒排序
//此算法与冒泡排序的不同处在于从低到高然后从高到低，而冒泡排序则仅从低到高去比较序列里的每个元素
void CocktailSort(int A[], int n)
{
    int left = 0;                            // 初始化边界
    int right = n - 1;
    while (left < right)
    {
        for (int i = left; i < right; i++)   // 前半轮,将最大元素放到后面
        {
            if (A[i] > A[i + 1])
            {
                swap(A, i, i + 1);
            }
        }
        right--;
        for (int i = right; i > left; i--)   // 后半轮,将最小元素放到前面
        {
            if (A[i - 1] > A[i])
            {
                swap(A, i - 1, i);
            }
        }
        left++;
    }
}

#pragma mark - 插入排序的改进：二分插入排序
//对于插入排序，如果比较操作的代价比交换操作大的话，可以采用二分查找法来减少比较操作的次数，我们称为二分插入排序
void InsertionSortDichotomy(int A[], int n)
{
    for (int i = 1; i < n; i++)
    {
        int get = A[i];                    // 右手抓到一张扑克牌
        int left = 0;                    // 拿在左手上的牌总是排序好的，所以可以用二分法
        int right = i - 1;                // 手牌左右边界进行初始化
        while (left <= right)            // 采用二分法定位新牌的位置
        {
            int mid = (left + right) / 2;
            if (A[mid] > get)
                right = mid - 1;
            else
                left = mid + 1;
        }
        for (int j = i - 1; j >= left; j--)    // 将欲插入新牌位置右边的牌整体向右移动一个单位
        {
            A[j + 1] = A[j];
        }
        A[left] = get;                    // 将抓到的牌插入手牌
    }
}

#pragma mark - 创建单向链表

void linkDemo() {
    int a [] = {1,2,3,4,5,6,7,8,9};
    LinkData *head = createLink(a, sizeof(a)/sizeof(int));
    head =  reverseLink(head);
    
    while (head) {
        printf("%d", head->data);
        head = head->nextPoint;
    }
}

LinkData *createLink(int A[], int size) {
    LinkData *head = NULL;
    LinkData *tempLink = NULL;
    
    for (int i = 0; i < size; i ++) {
        LinkData *temp = malloc(sizeof(LinkData));
        temp -> data = A[i];
        temp -> nextPoint = NULL;
        if (head == NULL) {
            head = temp;
            tempLink = head;
        }
        else {
            tempLink -> nextPoint = temp;
            tempLink = temp;
        }
    }
    return head;
}

LinkData *reverseLink(LinkData *link) {
    LinkData *tempLink = link;
    LinkData *next = NULL;
    LinkData *pre = NULL;
    while (tempLink) {
        if (tempLink == link) { //头
            next = tempLink -> nextPoint;
            tempLink -> nextPoint = NULL;
            pre = tempLink;
        }
        else {
            next = tempLink -> nextPoint;
            tempLink -> nextPoint = pre;
            pre = tempLink;
        }
        tempLink = next;
    }
    return pre;
}




@end
