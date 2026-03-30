# OSS_Audit_24BCE11482
# OSS Audit — Python Programming Language
## Open Source Software Capstone Project | VIT Bhopal
 
| Field | Details |
|-------|---------|
| **Student Name** | Anurag Tiwari |
| **Registration Number** | 24BCE11341 |
| **Course** | Open Source Software (OSS NGMC) |
| **Chosen Software** | Python Programming Language |
| **License** | PSF License v2 |
 
---
 
## Repository Structure
 
```
OSS_Audit_[rollnumber]/
├── README.md
├── script1_system_identity.sh
├── script2_foss_inspector.sh
├── script3_disk_auditor.sh
├── script4_log_analyzer.sh
└── script5_manifesto.sh
```
 
---
 
## Script Descriptions
 
### Script 1 — System Identity Report (`script1_system_identity.sh`)
Displays a formatted welcome screen summarising the Linux system. Shows the distribution name, kernel version, current logged-in user, home directory, system uptime, date and time, and the open-source licence covering the OS (GPL v2).
 
**Shell concepts used:** variables, command substitution `$()`, `if [ -f ]` file check, `grep`, `cut`, `tr`, formatted `echo` output.
 
---
 
### Script 2 — FOSS Package Inspector (`script2_foss_inspector.sh`)
Checks whether a specified package (defaults to `python3`) is installed on the system. If installed, it retrieves version and maintainer metadata using `dpkg` or `rpm`. A `case` statement then prints a short philosophical note about the package based on its name.
 
**Shell concepts used:** `if-elif-else`, `case` statement, `dpkg -s` / `rpm -qi`, pipe with `grep`, default argument with `${1:-default}`.
 
---
 
### Script 3 — Disk and Permission Auditor (`script3_disk_auditor.sh`)
Loops through a predefined list of important Linux system directories (`/etc`, `/var/log`, `/home`, `/usr/bin`, `/tmp`, `/usr/lib`, `/opt`) and reports the permissions, owner/group, and disk usage of each. Also checks for the Python binary and its site-packages directories.
 
**Shell concepts used:** `for` loop over an array, `[ -d ]` directory check, `ls -ld`, `du -sh`, `awk`, `which`, `printf` for aligned output.
 
---
 
### Script 4 — Log File Analyzer (`script4_log_analyzer.sh`)
Reads a log file line by line, counts how many lines contain a specified keyword (defaults to `error`), and prints the last 5 matching lines. Accepts the log file path and keyword as command-line arguments. Includes a retry loop if the file is temporarily unavailable.
 
**Shell concepts used:** `while IFS= read -r` loop, `if-then` inside loop, counter variable `$((COUNT + 1))`, `$1` and `$2` arguments, `grep -i` case-insensitive search, `tail`, retry logic with `sleep`.
 
---
 
### Script 5 — Open Source Manifesto Generator (`script5_manifesto.sh`)
Interactively asks the user three questions about open-source tools and values. Composes a personalised open-source philosophy paragraph from their answers and saves it to a uniquely named `.txt` file, then displays it on screen.
 
**Shell concepts used:** `read -p` interactive input, string concatenation with variables, `>` to create a file, `>>` to append, `date` command, `$(whoami)` command substitution, alias tip in comments.
 
---
 
## Dependencies
 
All scripts require only a standard **bash** shell and standard Linux utilities. No additional packages need to be installed.
 
| Utility | Used In | Typically Provided By |
|---------|---------|-----------------------|
| `bash` | All scripts | Pre-installed on all Linux systems |
| `uname`, `uptime`, `date`, `whoami` | Script 1, 5 | `coreutils` (pre-installed) |
| `dpkg` | Scripts 2, 3 | Pre-installed on Debian/Ubuntu |
| `rpm` | Scripts 2, 3 | Pre-installed on RHEL/Fedora/CentOS |
| `grep`, `awk`, `cut`, `tr` | Scripts 1, 2, 3, 4 | `grep`, `gawk`, `coreutils` (pre-installed) |
| `du`, `ls`, `printf` | Script 3 | `coreutils` (pre-installed) |
| `tail` | Script 4 | `coreutils` (pre-installed) |
 
---
 
## How to Run Each Script on Linux
 
### Step 1 — Clone the repository
```bash
git clone https://github.com/Theanuragtiwari/OSS_Audit_24BCE11341.git
cd OSS_Audit_24BCE11341
```
 
### Step 2 — Make scripts executable
```bash
chmod +x *.sh
```
 
### Step 3 — Run each script
 
**Script 1 — System Identity Report**
```bash
./script1_system_identity.sh
```
 
**Script 2 — FOSS Package Inspector**
```bash
# Check default package (python3)
./script2_foss_inspector.sh
 
# Check a specific package
./script2_foss_inspector.sh git
./script2_foss_inspector.sh firefox
```
 
**Script 3 — Disk and Permission Auditor**
```bash
./script3_disk_auditor.sh
```
> Note: Some directory sizes (like `/var/log`) may show `N/A` without `sudo` due to read permissions.
 
**Script 4 — Log File Analyzer**
```bash
# Basic usage — search for 'error' (default keyword)
./script4_log_analyzer.sh /var/log/syslog
 
# Search for a custom keyword
./script4_log_analyzer.sh /var/log/syslog warning
 
# On systems using journald instead of syslog:
./script4_log_analyzer.sh /var/log/kern.log error
```
 
**Script 5 — Open Source Manifesto Generator**
```bash
./script5_manifesto.sh
```
Follow the three interactive prompts. Your manifesto will be saved as `manifesto_[username]_[timestamp].txt` in the current directory.
 
---
 
## Notes
 
- Scripts 1–3 and 5 run without any arguments and produce output immediately.
- Script 4 requires a readable log file path as its first argument.
- Script 2 will report "NOT installed" if the package manager (`dpkg`/`rpm`) is not available — this is expected on minimal container environments.
