#!/bin/bash
echo "Current running processes:"
ps aux --sort=-%mem | head -n 10  
