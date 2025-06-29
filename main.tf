- name: Build Docker image
  uses: docker/build-push-action@v3
  with:
    context: .
    push: false
    tags: the-button:${{ github.sha }}
    load: true
    
- name: Run Trivy vulnerability scanner
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: 'the-button:${{ github.sha }}'
    format: 'table'
    exit-code: '0'
    ignore-unfixed: true
    severity: 'CRITICAL,HIGH'
    timeout: '5m'
    
- name: Test Docker image
  run: |
    docker run --name test-container -d -p 8000:8000 the-button:${{ github.sha }}

 logging: enabled: true
