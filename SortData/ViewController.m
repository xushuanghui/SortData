//
//  ViewController.m
//  SortData
//
//  Created by shuanghui xu on 2018/1/9.
//  Copyright © 2018年 shuanghui xu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    int A[] = {5,7,2,9,6,3,8};
    int n = sizeof(A) / sizeof(int);
    
    bubbleSort(A,n);
    
    
    for (int i = 0; i < n; i ++) {
        printf("%d",A[i]);
    }
    
}

#pragma mark - 冒泡排序  O(n^2)
void bubbleSort(int A[],int n) {
    for (int i = 0; i < n-1; i ++) {
        for (int j = 0; j < n-1-i; j ++) {// 依次比较相邻的两个元素,使较大的那个向后移
            if (A[j] > A[j+1]) {
                Swap(A, A[j], A[j+1]);
            }
        }
    }

}

void Swap(int A[], int i, int j)
{
    int temp = A[i];
    A[i] = A[j];
    A[j] = temp;
}


#pragma mark - 选择排序 O(n^2)

void selectionSort(int A[],int n) {
    for (int i = 0; i < n-1; i ++) {
        int min = i;
        for (int j = i+1; j < n-1; j ++) { //循环一轮，标记最小的序号
            if (A[j] < A[min]) {
                min = j;
            }
        }
        if (i != min) {
            Swap(A, i, min);
        }
    }
}


#pragma mark - 插入排序 O(n^2)

void insertSort(int A[],int n) {
    for (int i = 1; i < n; i++) {
        int get = A[i];//插入的新数
        int j = i-1;//插入数，左边依次递减的已经排序好的数 (对比)
        while (j >= 0 && get < A[j]) {
            A[j+1] = A[j]; //右移
            j --;
        }
        A[j+1] = get;//插入到比get数小的值右边
    }
}

#pragma mark - 堆排序 O(nlogn)

void heapSort(int A[],int size) {
    buildHeap(A, size);
    int heapSize = size;
    while (heapSize>1) {
        Swap(A, 0, --heapSize);//堆顶与最后一个数交换
        heapify(A, 0, heapSize);//重新从堆顶向下开始调整最大堆
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
    int max = A[i];
    if (left < size && max < A[left]) {
        max = A[left];
    }
    if (right < size && max < A[right]) {
        max = A[right];
    }
    if (i != max) {
        Swap(A, i, max);//交换
        heapify(A,max,size);//继续向下排序
    }
    
}


#pragma mark = 快速排序 O(nlogn)
//void


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
