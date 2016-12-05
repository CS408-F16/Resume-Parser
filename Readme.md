# Resume Parser

A resume parser written in DLang supplemented by a tool that converts .docx files to .txt.

In order to run Resume Parser you'll need to install the following

- Eclipse 4.6 (Neon) or newer (http://www.eclipse.org/downloads/eclipse-packages/)
- DDT Plugin for Eclipse (http://ddt-ide.github.io/)
- Microsoft Visual Studio Community 2015 or newer (https://www.visualstudio.com/vs/community/)
- DMD Compiler (https://dlang.org/download.html)
- Microsoft Office Primary Interop Assembiles (https://www.microsoft.com/en-us/download/details.aspx?id=18346)

To compile and run the C# portion:

 - Install Microsoft Visual Studio Community 2015
 - Install Microsoft Office Primary Interop Assemblies
 - Open Microsoft Visual Studio Community 2015
 - Go to menu File >> Open >> Project/Solution... and navigate to the WordParser directory
 - Go to menu Build >> Build WordToTxt
 - Go to menu Debug >> Start Debugging
 
 > Note that the C# portion requires Resume.docx to reside in the same directory as WordToTxt.exe

To compile and run the DLang portion:

- Install DMD Compiler
- Install Eclipse 4.6
- Install DDT Plugin for Eclipse
- Open Eclipse 4.6
- Go to menu File >> Open Projects from File System... and navigate to the Resume-Parser directory
- Go to menu Project >> Build All
- Go to menu Project >> Run

> Note that the DLang portion requires WordToTxt.exe and Resume.docx to reside in the same directory as the resume-parser.exe
