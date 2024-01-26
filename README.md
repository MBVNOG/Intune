Script to deploy the microsoft hotfix that fixes the issues from KB5034441 with the Win RE update.

Create a Windows remediation, with adding the detect and remediate script into the remediation.
The 3rd script is made by Microsoft to fix this issue.

The detect script checks if the hotfix is installed. 
If not, the remediation script runs the 3rd script via Intune to fix this issue.

################################################################################################

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT License.

 THE SOFTWARE IS PROVIDED *AS IS*, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.

################################################################################################

 Sourcecode Downloaded from Microsoft: 
 https://support.microsoft.com/en-us/topic/kb5034957-updating-the-winre-partition-on-deployed-devices-to-address-security-vulnerabilities-in-cve-2024-20666-0190331b-1ca3-42d8-8a55-7fc406910c10
 to fix KB5034441 issues:
 https://support.microsoft.com/nl-nl/topic/kb5034441-windows-recovery-environment-update-voor-windows-10-versie-21h2-en-22h2-9-januari-2024-62c04204-aaa5-4fee-a02a-2fdea17075a8
 - Edited by Marcel Boom - m.boom@vnog.nl to optimize formatting and readability
 - Added creating of a logfile next to the onscreen logging for usage in Intune scripting and advanced troubleshooting

################################################################################################
