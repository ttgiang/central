/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 */

//
// TaskBean.java
//
package com.ase.aseutil.task;

import java.io.Serializable;

public class TaskBean implements Runnable, Serializable {

	private static final long serialVersionUID = 12L;

    private int counter;
    private int sum;
    private boolean started;
    private boolean running;
    private int sleep;

    public TaskBean() {
        counter = 0;
        sum = 0;
        started = false;
        running = false;
        sleep = 100;
    }

    protected void work() {
        try {
            Thread.sleep(sleep);
            counter++;
            sum += counter;
        } catch (InterruptedException e) {
            setRunning(false);
        }
    }

    public synchronized int getPercent() {
        return counter;
    }

    public synchronized boolean isStarted() {
        return started;
    }

    public synchronized boolean isCompleted() {
        return counter == 100;
    }

    public synchronized boolean isRunning() {
        return running;
    }

    public synchronized void setRunning(boolean running) {
        this.running = running;
        if (running)
            started = true;
    }

    public synchronized Object getResult() {
        if (isCompleted())
            return new Integer(sum);
        else
            return null;
    }

    public void run() {
        try {
            setRunning(true);
            while (isRunning() && !isCompleted())
                work();
        } finally {
            setRunning(false);
        }
    }

}
