# IMAPSync Installation Guide for Windows (local)

Run `install.ps1` in powershell with administrative rights OR:

## Step 1: Download Cygwin Installer

1. Visit the [Cygwin website](https://www.cygwin.com).
2. Click on **Install Cygwin** to download the setup executable:
   - For 64-bit Windows, download `setup-x86_64.exe`.
   - For 32-bit Windows, download `setup-x86.exe`.

## Step 2: Run the Cygwin Installer

1. **Run the downloaded setup executable**.
2. Click **Next** to proceed.
3. On the **Choose Installation Type** screen, select **Install from Internet** and click **Next**.
4. On the **Choose Installation Directory** screen, enter `C:\cygwin` as the Root Directory (or choose another directory) and click **Next**.
5. On the **Select Local Package Directory** screen, choose a directory to store downloaded installation files and click **Next**.
6. On the **Select Connection Type** screen, choose your internet connection type (usually **Direct Connection**) and click **Next**.
7. On the **Choose Download Site(s)** screen, select a mirror site from the list and click **Next**.

## Step 2: Using Command-line to install Cygwin with required packages

1. Open command-prompt and run:

```bash
$ setup-x86_64.exe -q -P gcc-core,g++,make,perl,perl-Digest-HMAC,perl-IO-Socket-SSL,perl-Socket6,libcrypt-devel
```

## Step 3: Select Cygwin Packages (skip if using Command-line to install Cygwin)

1. On the **Select Packages** screen:

   - Select all these essential packages:

     - `gcc-core` (GNU Compiler Collection): A compiler system supporting various programming languages, primarily C and C++.

     - `g++` (GNU C++ Compiler): The GNU C++ compiler, used for compiling C++ programs.

     - `make` (Build automation tool): A tool that automatically builds executable programs and libraries from source code.

     - `perl` (Practical Extraction and Report Language): A high-level programming language known for its text processing capabilities.

     - `perl-Digest-HMAC` (Keyed-Hashing for Message Authentication): A Perl module that implements HMAC (Hash-based Message Authentication Code) for message integrity checks between two parties sharing a secret key. [More Info](https://metacpan.org/pod/Digest::HMAC)

     - `perl-IO-Socket-SSL` (SSL support for IO::Socket): A Perl module that provides SSL support to IO::Socket, enabling secure communications over the network.

     - `perl-Socket6` (IPv6 support for IO::Socket): A Perl module that provides support for IPv6 networking in Perl scripts.

     - `libcrypt-devel` (Development files for cryptography): A package that includes development files necessary for building applications that use cryptographic functions.

2. Click **Next** to proceed with downloading and installing selected packages.

## Setp 4: Install Required Perl Modules using Cygwin

1. Install CPAN Minus (cpanm)

```bash
$ perl -MCPAN -e 'install App::cpanminus'
```

2. Install required Perl modules

```bash
$ cpanm Encode::IMAPUTF7 File::Copy::Recursive IO::Socket::INET6 Term::ReadKey Readonly Sys::MemInfo Regexp::Common File::Tail Digest::HMAC
```

## Step 4: Download and Prepare IMAPSync using Cygwin

1. Download the latest version of IMAPSync from its official site [IMAPSync](https://imapsync.lamiral.info/X/)
2. Alternatively, you can clone the repository from GitHub: `git clone https://github.com/imapsync/imapsync.git` (recommended)
3. Change to the directory where IMAPSync is located

```bash
$ cd imapsync
```

4. Run the following command to make the script executable (make sure to run Cygwin as Administrator)

```bash
$ chmod +x imapsync
```

## Step 5: Verify Installation

1. Open the Cygwin terminal by running `C:\cygwin\Cygwin.bat`.
2. To verify that IMAPSync is working correctly, run:

```bash
$ ./imapsync -help
$ ./imapsync --testslive # OR
# change values accordingly - you only need to define host1 to verify
$ ./imapsync --host1 source.imap.server --user1 user1@example.com --password1 'password1'             --host2 destination.imap.server --user2 user2@example.com --password2 'password2' --justlogin
# check output or the relevant log file under ./imapsync/LOG_imapsync/
```

## Issues

1. If you encounter any issues related to missing Perl modules, you can update them using cpanm. For example, if you need to update IO::Socket::SSL, run:

```bash
$ cpanm IO::Socket::SSL
```
