# ==========================================
# Étape 2 : Image de production 
# ==========================================
FROM node:20-alpine AS runner

WORKDIR /app

ENV NODE_ENV=production

# Création d'un utilisateur non-privilégié
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Copie des package.json AVEC les bons droits pour l'utilisateur nodejs
COPY --chown=nodejs:nodejs package*.json ./

RUN npm ci --only=production && npm cache clean --force

# Copie du code source avec les bons droits
COPY --chown=nodejs:nodejs src/ ./src/

# Passage à l'utilisateur non-root
USER nodejs

EXPOSE 3000

CMD ["npm", "start"]