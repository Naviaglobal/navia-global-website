export default async function handler(req, res) {
  if (req.method !== 'POST') return res.status(405).end();
  const { files, secret } = req.body;
  if (secret !== 'navia2026push') return res.status(403).json({error:'forbidden'});
  const token = process.env.GITHUB_TOKEN;
  if (!token) return res.status(500).json({error:'no token'});
  const results = [];
  for (const {path, content} of files) {
    const getR = await fetch(`https://api.github.com/repos/Naviaglobal/navia-global-website/contents/${path}`,{headers:{Authorization:`Bearer ${token}`,Accept:'application/vnd.github.v3+json'}});
    const fileData = await getR.json();
    const putR = await fetch(`https://api.github.com/repos/Naviaglobal/navia-global-website/contents/${path}`,{method:'PUT',headers:{Authorization:`Bearer ${token}`,'Content-Type':'application/json'},body:JSON.stringify({message:`fix: ${path}`,content:Buffer.from(content).toString('base64'),sha:fileData.sha})});
    const r = await putR.json();
    results.push({path, ok:putR.ok, commit:r.commit?.sha||r.message});
  }
  return res.json({results});
}
